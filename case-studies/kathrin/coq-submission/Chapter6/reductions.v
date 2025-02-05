(** ** Substitutivity proofs of reduction. *)

(** *** Substitutivity for the Lambda Calculus with Pairs *)

Module polyadic.
Section polyadic.
  From Chapter6 Require Export utlc_pairs.
  Import fintype. 

  Local Open Scope subst_scope. 

  Inductive step {m} : tm m -> tm m -> Prop :=
  | beta s t t' : t' = (s[t..]) -> step (utlc_pairs.app (lam s) t) t'
  | beta_match s1 s2 t t' : t' = (t[s1 .: s2..]) -> step (matchpair (pair s1 s2) t) t'.


  Lemma step_substitutive m m' (s: tm m) t (sigma: fin m -> tm m')  :
    step s t -> step (s[sigma]) (t[sigma]).
  Proof.
    induction 1; subst.
    - cbn. constructor. now asimpl.
      (* auto_unfold. *)
      (* rewrite ?compComp_tm. *)
      (* unfold up_ren, upRen_tm_tm, upRen_list_tm_tm, up_tm_tm, up_list_tm_tm. *)
      (* (* Unset Printing Notations. *) *)
      (* fsimpl. *)
      (* rewrite ?renComp'_tm. *)
      (* rewrite ?instId_tm. *)
      (* rewrite ?varL_tm. *)
      (* cbn[subst_tm ren_tm]. *)
      (* fsimpl. *)
      (* Info 2 asimpl. *)
    - cbn. constructor. now asimpl.
Qed.

End polyadic.
End polyadic.

(** *** Substitutivity for Call-by-Value System F *)

Module sysf_cbv.
Section sysf_cbv.
  From Chapter6 Require Export sysf_cbv.
  Import fintype. 

  (* Local Open Scope subst_scope.  *)

  Inductive step {m n} : tm m n -> tm m n -> Prop :=
  | beta A s v t : t = (s[ids;v..]) -> step (sysf_cbv.app (vt (lam A s)) (vt v)) t
  | Beta s A t: t = (s[A..;ids]) ->  step (tapp (vt (tlam s)) A) t.

  Lemma step_substitutive m n m' n' (s: tm m n) t sigma (tau: fin n -> vl m' n'):
    step s t -> step (s[sigma;tau]) (t[sigma;tau]).
  Proof.
    induction 1; subst.
    - cbn. constructor. now asimpl.
    - cbn. constructor. now asimpl.
  Qed.


End sysf_cbv.
End sysf_cbv.
