-- Starting point

import System.Cmd
import Text.HTML.TagSoup
import Scraper.Scraper

hnRss = "https://news.ycombinator.com/rss"

-- As a start write a tool to read Hacker news on the command line
-- Following would be an example
-- <?xml version="1.0" encoding="UTF-8"?>
-- <rss version="2.0">
--    <channel>
--       <title>Hacker News</title>
--       <link>https://news.ycombinator.com/</link>
--       <description>Links for the intellectually curious, ranked by readers.</description>
--       <item>
--          <title>How Steve Wozniak Wrote BASIC for the Original Apple From Scratch</title>
--          <link>http://gizmodo.com/how-steve-wozniak-wrote-basic-for-the-original-apple-fr-1570573636/all</link>
--          <comments>https://news.ycombinator.com/item?id=7687174</comments>
--          <description><![CDATA[<a href="https://news.ycombinator.com/item?id=7687174">Comments</a>]]></description>
--       </item>
--     </channel>
-- </rss>

data HackerNewsItem = HackerNewsItem { title :: !String
                                     , link :: !String
                                     , comments :: !String
                                     , description :: !String
                                     } deriving (Show, Eq)

-- TODO: Enhance this function to be cross platform compatible
-- Refer: http://stackoverflow.com/questions/1795111/is-there-a-cross-platform-way-to-open-a-file-browser-in-python
openUrlInBrowser cmd = system openCmd
  where openCmd = "open " ++ cmd

bogusNews = [ HackerNewsItem { title = "abc"
                             , link = "https://www.google.com"
                             , comments = "abc comments"
                             , description = "abc description" }
            , HackerNewsItem { title = "def"
                             , link = "https://www.bing.com"
                             , comments = "def comments"
                             , description = "def description" }
            ]

printNews :: [HackerNewsItem] -> IO ()
printNews = mapM_ (putStrLn . show) . zip [1..] . map title

processCmdInput news = do
  putStr "> "
  cmd <- getLine
  case cmd of
    "d" -> displayNews
    "display" -> displayNews
    "e" -> exit
    "exit" -> exit
    ('r':' ':num) -> displayItem num
    ('r':'e':'a':'d':' ':num) -> displayItem num
    _ -> unknown cmd
  where
    displayNews = do { putStrLn "Displaying";
                       printNews news;
                       processCmdInput news
                     }

    exit = putStrLn "Bye..."

    unknown cmd = do { putStrLn $ "Error: unknown command " ++ cmd;
                       processCmdInput news
                     }

    displayItem snum = do { putStrLn $ "Displaying news item: " ++ snum;
                            let n = (read snum) :: Int
                                newsUrl = link $ news !! n
                            in openUrlInBrowser newsUrl;
                            processCmdInput news
                         }

printTags page = print $ parseTags page

printOnlineNews = do
  res <- processPage hnRss 
  case res of
    Left code -> putStrLn $ "Failed to process with code " ++ (show res)
    Right (page, _) -> do {
      putStrLn "Here's the page";
      printTags page
      -- putStrLn page
      }

main = do
  putStrLn "Starting HTrapIt"
