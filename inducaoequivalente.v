(** Equivalência entre o Princípio da Indução Matemática e o Princípio da Indução Forte *)
(* begin hide *)
Require Import Arith.
Require Import Lia.
Require Import Classical.
(* end hide *)

(** Seja [P] uma propriedade sobre os números naturais. O Princípio da
    Indução Matemática (PIM) pode ser enunciado da seguinte forma: *)
Definition PIM :=
  forall P: nat -> Prop,
    (P 0) ->
    (forall k, P k -> P (S k)) ->
    forall n, P n.

(** Seja [Q] uma propriedade sobre os números naturais. O Princípio da
    Indução Forte (PIF) pode ser enunciado da seguinte forma: *)
Definition PIF :=
  forall Q: nat -> Prop,
    (forall k, (forall m, m<k -> Q m) -> Q k) ->
    forall n, Q n.

(** Dado um predicado [P] sobre naturais, se existe um natural [n] que
    satisfaz a propriedade [P], então existe um [m] que é o menor natural
    que satisfaz a propriedade [P]. Esta propriedade é conhecida como o
    Princípio da Boa Ordenação (PBO): *)
Definition PBO := forall P : nat -> Prop,
  (exists n : nat, P n) ->
  exists m : nat, P m /\ forall x : nat, x < m -> ~ P x.

(** * PIM <-> PIF *)

Theorem PIM_equiv_PIF: PIM <-> PIF.
Proof.
  split.
  - (* PIM -> PIF *)
    intros HPIM Q HQ n.
    assert (Haux: forall n, forall m, m <= n -> Q m).
    { apply (HPIM (fun n => forall m, m <= n -> Q m)).
        intros m Hm.
        assert (m = 0) by lia. subst.
        apply HQ. intros m' Hm'. lia.
        intros k IH m Hm.
        assert (m <= k \/ m = S k) as [Hle | Heq] by lia.
        + apply IH. assumption.
        + subst. apply HQ. intros m' Hm'. apply IH. lia.
    }
    apply (Haux n n). lia.
  - (* PIF -> PIM *)
    intros HPIF P P0 Pstep n.
    apply HPIF.
    intros k IH.
    destruct k as [|k'].
    + exact P0.
    + apply Pstep. apply IH. lia.
Qed.

(** * PBO <-> PIM *)

Theorem PBO_equiv_PIM: PBO <-> PIM.
Proof.
  split.
  - (* PBO -> PIM *)
    intros HPBO P HP0 Hstep n.
    destruct (classic (P n)) as [H | H].
    + exact H.
    + exfalso.
      destruct (HPBO (fun x => ~ P x) (ex_intro _ n H)) as [m [Hm Hmin]].
      destruct m as [|k].
      * apply Hm. exact HP0.
      * apply Hm. apply Hstep.
        destruct (classic (P k)) as [HPk | HPk].
        -- exact HPk.
        -- exfalso. apply (Hmin k). lia. exact HPk.
  - (* PIM -> PBO *)
    intros HPIM P [n0 Hn0].
    revert Hn0.
    pattern n0.
    apply (proj1 PIM_equiv_PIF HPIM).
    intros n IH Hn.
    destruct (classic (exists k, k < n /\ P k)) as [[k [Hk HPk]] | Hno].
    + exact (IH k Hk HPk).
    + exists n. split.
      * exact Hn.
      * intros x Hx HPx. apply Hno. exists x. split; assumption.
Qed.

(** * PBO <-> PIF *)

Theorem PBO_equiv_PIF: PBO <-> PIF.
Proof.
  split.
  - intro HPBO.
    exact (proj1 PIM_equiv_PIF (proj1 PBO_equiv_PIM HPBO)).
  - intro HPIF.
    exact (proj2 PBO_equiv_PIM (proj2 PIM_equiv_PIF HPIF)).
Qed.
