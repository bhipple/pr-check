{-# LANGUAGE OverloadedStrings #-}

import PrCheck

import GitHub.Auth
import qualified Data.Vector as V

testGetRepoNames :: Auth -> IO ()
testGetRepoNames auth = do
    repos <- orgRepoNames auth "scrp"
    V.mapM_ print repos

testGetWebhooks :: Auth -> String -> IO ()
testGetWebhooks = undefined

main :: IO ()
main = do
    auth <- getAuth
    case auth of
        Nothing -> print "Authentication failure. $GITHUB_TOKEN?"
        Just a -> testGetRepoNames a
