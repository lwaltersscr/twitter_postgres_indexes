-- Improve tag-based filters and joins
CREATE INDEX IF NOT EXISTS idx_tweet_tags_tag ON tweet_tags(tag);
CREATE INDEX IF NOT EXISTS idx_tweet_tags_id_tag ON tweet_tags(id_tweets, tag);

-- Improve tweet filtering by language and id
CREATE INDEX IF NOT EXISTS idx_tweets_id_lang ON tweets(id_tweets, lang);

-- Full-text search optimization on tweet text
CREATE INDEX IF NOT EXISTS idx_tweets_text_gin ON tweets USING GIN (to_tsvector('english', text));

