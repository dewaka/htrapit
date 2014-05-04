module Scraper.Scraper where

import Network.Curl (curlGetString)
import Network.Curl.Code

type PageProcessor = (String -> Bool)
type ErrorProcessor = (CurlCode -> Bool)

processPage :: String -> IO (Either CurlCode (String, CurlCode))
processPage url = do
  (status, page) <- curlGetString url []
  case status of
    CurlOK -> return $ Right (page, status)
    _ -> return $ Left status
