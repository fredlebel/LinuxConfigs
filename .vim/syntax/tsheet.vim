if exists("b:current_syntax")
  finish
endif

syn keyword tsKeywords Monday Tuesday Wednesday Thursday Friday Saturday Sunday
syn match tsComment "==.*$"
syn region tsNoWork start='<' end='>'
syn region tsHours start='\[' end=']'

let b:current_syntax = "tsheet"
hi def link tsComment Comment
hi def link tsKeywords Function
hi def link tsHours Keyword
hi def link tsNoWork Character

