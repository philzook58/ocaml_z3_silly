# ocaml_z3_silly

`dune exec ./main.ml`

Gaving difficulty getting the model out of an arrya

FuncInterp seems like the functionality that I want, but does not appear to be obviously working.
Using Model.eval to work my way around doesn't seem to be working

I could deconstruct the ast, but feels hacky.

Most relevant stack overflow answer appears here.
https://stackoverflow.com/questions/22885457/read-func-interp-of-a-z3-array-from-the-z3-model/22918197#22918197

```
sat                
(define-fun f () (Array Int Int)
  (store ((as const (Array Int Int)) 41) 4 7723))
constdecls (declare-fun f () (Array Int Int))
decls: (declare-fun f () (Array Int Int))
Fatal error: exception Z3.Error("Argument was not an array constant")
```

(Z3.Model.get_func_interp  model f_decl) leads to 
Fatal error: exception Z3.Error("Argument was not an array constant")
get_const_interp also errors out.
