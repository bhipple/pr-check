{-# LANGUAGE OverloadedStrings #-}

module PrCheck
    ( someFunc,
      orgRepoNames
    ) where

import GitHub
import GitHub.Endpoints.PullRequests
import GitHub.Endpoints.Repos
import Data.List
import Data.Text
import qualified Data.Vector as V

someFunc :: IO ()
someFunc = do
    pulls <- pullRequestsFor "aslatter" "parsec"
    case pulls of
        (Left error) -> putStrLn "Error"
        (Right pullRequests) -> do
             putStrLn "These are the pull requests:"
             mapM_ print pullRequests

orgRepoNames :: Text -> IO ()
orgRepoNames org = do
    resp <- organizationRepos $ mkOrganizationName org
    case resp of
        (Left error) -> putStrLn "Error getting org repos"
        (Right repos) -> do
            let names = V.map repoName repos
            V.mapM_ print names
