# README

Version 1 of the Search Implementation. 

- I've exported the REST API calls to a workspace (added it to `test/search.json`).
- I've also included the `db/development.sqlite3` database for your convenience (_it shows the data I used to write this_).


## NOTE

- The current implementation **only** supports 1 level of networking.
- I didn't get a chance to write the tests or implement the UI as I ran out of time.
- I tried to implement a generic (recursive) algorithm to support a few more levels of networking but quickly realized the requirement would need to actually cap the levels at some point (_short of it becoming extraordinarily complex_).
- So, while the current implementation supports 1-level and produces an output like this:

```
[
  "varun -> krish -> raj",
  "varun -> meena -> obama",
  "varun -> krish -> fauci"
]
```

it **does not** support these use cases (_as an example_):


``` 
varun -> krish -> nancy -> reagan -> obama 
varun -> krish -> carter -> reagan -> obama 
varun -> krish -> nancy -> george -> obama 
```