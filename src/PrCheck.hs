{-# LANGUAGE OverloadedStrings #-}

module PrCheck
    ( getAuth
    , orgRepoNames
    ) where

import GitHub
import Data.List
import Data.Text
import GitHub.Auth
import GitHub.Endpoints.PullRequests
import GitHub.Endpoints.Repos
import System.Environment (lookupEnv)
import Data.String (fromString)
import qualified Data.ByteString as BS
import qualified Data.Vector as V

getAuth :: IO (Maybe GitHub.Auth)
getAuth = do
    token <- lookupEnv "GITHUB_TOKEN"
    pure (GitHub.EnterpriseOAuth "https://bbgithub.dev.bloomberg.com/api/v3" . fromString <$> token)

orgRepoNames :: GitHub.Auth -> Text -> IO (V.Vector (Name Repo))
orgRepoNames auth org = do
    resp <- organizationRepos' (Just auth) (mkOrganizationName org) RepoPublicityAll
    case resp of
        (Left error) -> do
            putStrLn "Error getting org repos"
            pure $ V.fromList []
        (Right repos) -> pure $ V.map repoName repos

getWebhooks :: GitHub.Auth -> Text -> Text -> IO (V.Vector RepoWebhook)
getWebhooks = undefined
