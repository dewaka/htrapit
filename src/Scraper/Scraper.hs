module Scraper where

import Network.Curl (curlGetString)

processPage url onSuccess onFail = do
  (_, page) <- curlGetString url []
  onSuccess page
   
