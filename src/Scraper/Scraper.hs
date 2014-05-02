module Scraper where

import Network.Curl (curlGetString)
import Network.Curl.Code

type PageProcessor = (String -> Bool)
type ErrorProcessor = (CurlCode -> Bool)

processPage :: String -> PageProcessor -> ErrorProcessor -> IO Bool
processPage url onSuccess onFail = do
  (status, page) <- curlGetString url []
  case status of
    CurlOK -> return $ onSuccess page
    _ -> return $ onFail status
