open Core_kernel

let main () = let cfg = [] in
              let ctx = (Z3.mk_context cfg) in 
              (** goal is basically the entire problem *)
              (* let g = Z3.Goal.mk_goal ctx true false false in *) (** what the hell are these parameters? *)
              let solver = Z3.Solver.mk_solver ctx None in
              let three = Z3.Arithmetic.Integer.mk_numeral_i ctx 3 in
              let four = Z3.Arithmetic.Integer.mk_numeral_i ctx 4 in
              (* let x = (Z3.Symbol.mk_string ctx "x") in *)
              (* let x =  Z3.Arithmetic.Integer.mk_const_s ctx "x" in *)
              let c = Z3.Arithmetic.mk_ge ctx three x in
              let intsort = Z3.Arithmetic.Integer.mk_sort ctx in 
              let f =  Z3.Z3Array.mk_const_s ctx "f" intsort intsort in (* make new array *)
              let c' = Z3.Arithmetic.mk_ge ctx (Z3.Z3Array.mk_select ctx f three) three in
              let c'' = Z3.Arithmetic.mk_ge ctx (Z3.Z3Array.mk_select ctx f four) four in
              (* let () = Z3.Goal.add g [c ; c' ; c'' ] in *)
              let () = Z3.Solver.add solver [c ; c' ; c''] in
              match Z3.Solver.check solver [] with
                     | Z3.Solver.UNKNOWN -> ()
                     | Z3.Solver.UNSATISFIABLE -> ()
                     | Z3.Solver.SATISFIABLE ->
                           match Z3.Solver.get_model solver with
                                 | Some(model) -> Printf.printf "sat\n";
                                           Printf.printf "%s\n" (Z3.Model.to_string model);
                                           let decls = Z3.Model.get_const_decls model in
                                           List.iter decls ~f:(fun d -> Printf.printf "constdecls %s\n" (Z3.FuncDecl.to_string d)); 
                                           let decls = Z3.Model.get_decls model in
                                           List.iter decls ~f:(fun d -> Printf.printf "decls: %s\n" (Z3.FuncDecl.to_string d)); 
                                           let f_decl = Option.value_exn (List.hd decls) in
                                           let f_e = Option.value_exn (Z3.Model.eval model f false) in
                                           let _ = Option.value_exn (Z3.Model.get_func_interp  model f_decl) in
                                           Printf.printf "%s\n" (Z3.Expr.to_string f_e);

                                           ()

                                           (*
                                           let r = (Z3.FuncDecl.get_range f_decl) in 
                                           Printf.printf "range: %s\n" (Z3.Sort.to_string r);
                                           let _ = Z3.Sort.get_sort_kind  r in
                                           (*Printf.printf "range: %s\n" (Z3enums. to_string r); *)
                                           
                                           let app = Z3.FuncDecl.apply f_decl [] in
                                           Printf.printf "%d\n" (Z3.FuncDecl.get_arity f_decl) ;
                                           let params = (Z3.FuncDecl.get_parameters f_decl) in
                                           List.iter params  ~f:( fun p -> Printf.printf "Wha %s\n" (Z3.FuncDecl.to_string (Z3.FuncDecl.Parameter.get_func_decl p)));
                                           

                                           Printf.printf "%s\n" (Z3.Expr.to_string app) ;
                                           let body = Option.value_exn (Z3.Model.eval model app false) in 
                                           let body' = Option.value_exn (Z3.Model.eval model f false) in 
                                           Printf.printf "%s\n" (Z3.Expr.to_string body);
                                           Printf.printf "body' %s\n" (Z3.Expr.to_string body');
                                           Printf.printf "%s\n" (Z3.Expr.to_string (Z3.Expr.simplify body None));
                                           let fdecl = Z3.Expr.get_func_decl body in
                                           Printf.printf "funcdecl is now store? %s\n" (Z3.FuncDecl.to_string fdecl); (* nope. this is store *)
                                           let params = (Z3.FuncDecl.get_parameters fdecl) in
                                           List.iter params  ~f:( fun p -> Printf.printf "Wha %s\n" (Z3.FuncDecl.to_string (Z3.FuncDecl.Parameter.get_func_decl p)));
                                           (* let _ = Option.value_exn (Z3.Model.get_func_interp model fdecl) in *)
                                           let i = Z3.Model.eval model x false in 
                                           let i = match i with | Some(i') -> (Big_int.int_of_big_int (Z3.Arithmetic.Integer.get_big_int i')) | None -> 0 in
                                           Printf.printf "ignore this %d\n" i *)
                                 | _ ->    Printf.printf "wut?"
                     

let () = main ()
