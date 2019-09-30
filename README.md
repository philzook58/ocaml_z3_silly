# ocaml_z3_silly

`dune exec ./main.ml`

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
