;; capture the whole fenced code block as “outer”
(fenced_code_block) @code_block.outer

;; capture just the inner contents (i.e. between the ``` delimiters)
(fenced_code_block
  (code_fence_content) @code_block.inner
)

