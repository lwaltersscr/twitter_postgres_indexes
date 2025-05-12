-- Increase parallelism + memory for creation
SET max_parallel_maintenance_workers TO 80;
SET maintenance_work_mem TO '2GB';

-- Language filtering
CREATE INDEX IF NOT EXISTS idx_jsonb_lang ON tweets_jsonb ((data->>'lang'));

-- Full-text search on tweet text or extended tweet
CREATE INDEX IF NOT EXISTS idx_jsonb_text_search ON tweets_jsonb
  USING GIN (to_tsvector('english', COALESCE(data->'extended_tweet'->>'full_text', data->>'text')));

-- Hashtags (from both normal and extended tweet formats)
CREATE INDEX IF NOT EXISTS idx_jsonb_hashtags ON tweets_jsonb
  USING GIN ((data->'entities'->'hashtags'))
  WHERE jsonb_typeof(data->'entities'->'hashtags') = 'array';

CREATE INDEX IF NOT EXISTS idx_jsonb_ext_hashtags ON tweets_jsonb
  USING GIN ((data->'extended_tweet'->'entities'->'hashtags'))
  WHERE jsonb_typeof(data->'extended_tweet'->'entities'->'hashtags') = 'array';

