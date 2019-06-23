(*<*)
theory ChisholmExample
  imports TheoryCombination
begin
nitpick_params[user_axioms=true, show_all, expect=genuine, format = 3]
(*>*)
(****Chisholm Example (Propositional)****)
consts go::m tell::m
consts C::c
axiomatization where
 D1: "\<lfloor>\<^bold>O\<langle>go\<rangle>\<rfloor>" and (*It ought to be that Jones goes to assist his neighbour*)
 D2: "\<lfloor>\<^bold>O\<langle>tell|go\<rangle>\<rfloor>" and (*It ought to be that if Jones goes, then he tells them he is coming*)
 D3: "\<lfloor>\<^bold>O\<langle>\<^bold>\<not>tell|\<^bold>\<not>go\<rangle>\<rfloor>" and (*If Jones doesn't go, then he ought not tell them he is coming*)
 D4: "\<lfloor>\<^bold>\<not>(go)\<rfloor>\<^sub>C"  (*Jones doesn't go (locally valid statement)*)

lemma True nitpick [satisfy, user_axioms, expect=genuine, show_all, format=2] oops

abbreviation "violated \<phi> \<equiv> \<^bold>O\<^sub>i(\<phi>) \<^bold>\<and> \<^bold>\<not>\<phi>"

declare [[smt_solver=cvc4]]
declare [[smt_oracle]]


lemma "(\<lfloor>\<^bold>\<box>\<^sub>a\<^bold>\<not>(go)\<rfloor>\<^sub>C \<and> \<lfloor>\<^bold>\<diamond>\<^sub>p(go \<^bold>\<and> tell)\<rfloor>\<^sub>C \<and> \<lfloor>\<^bold>\<diamond>\<^sub>p(go \<^bold>\<and> \<^bold>\<not>tell)\<rfloor>\<^sub>C \<and> \<lfloor>\<^bold>\<not>tell\<rfloor>\<^sub>C \<and> \<lfloor>\<^bold>\<diamond>\<^sub>atell\<rfloor>\<^sub>C \<and>  \<lfloor>\<^bold>\<diamond>\<^sub>a(\<^bold>\<not>tell)\<rfloor>\<^sub>C)
       \<longrightarrow> (\<lfloor>violated go\<rfloor>\<^sub>C \<and> \<lfloor>\<^bold>O\<^sub>a(\<^bold>\<not>tell)\<rfloor>\<^sub>C)" 
  using sem_4a sem_4b sem_5e D1 D3 D4 sem_5b by smt

(*****Chisholm Paradox  (Enhanced)****)
type_synonym cwe = "c\<Rightarrow>w\<Rightarrow>e" \<comment> \<open>type alias for indexical individual terms\<close>
abbreviation I::cwe where "I \<equiv> \<lambda>c w. Agent c"

consts goPred::"e\<Rightarrow>m" \<comment> \<open> predicate: to go to assist one's neighbours\<close>
consts tellPred::"e\<Rightarrow>m" \<comment> \<open>predicate: to tell one is coming\<close>
abbreviation Go::"(c\<Rightarrow>w\<Rightarrow>e)\<Rightarrow>m"  where "Go \<alpha> \<equiv> \<lambda>c w. goPred (\<alpha> c w) c w"  \<comment> \<open>type-lifted predicate\<close>
abbreviation Tell::"(c\<Rightarrow>w\<Rightarrow>e)\<Rightarrow>m" where "Tell \<alpha> \<equiv> \<lambda>c w. tellPred (\<alpha> c w) c w"  \<comment> \<open>type-lifted\<close>

axiomatization where
 B1: "\<lfloor>\<^bold>O\<langle>Go(I)\<rangle>\<rfloor>\<^sup>D" and (*It ought to be that I go to assist my neighbours*)
 B2: "\<lfloor>\<^bold>O\<langle>Tell(I)|Go(I)\<rangle>\<rfloor>\<^sup>D" and (*It ought to be that if I go, then I tell them I am coming*)
 B3: "\<lfloor>\<^bold>O\<langle>\<^bold>\<not>Tell(I)|\<^bold>\<not>Go(I)\<rangle>\<rfloor>\<^sup>D" and (*If I don't go, then I ought not tell them I am coming*)
 B4: "\<lfloor>\<^bold>\<not>(Go(I))\<rfloor>\<^sub>C"  (*I don't go (locally valid statement)*)


lemma "(\<lfloor>\<^bold>\<box>\<^sub>a\<^bold>\<not>(Go(I))\<rfloor>\<^sub>C \<and> \<lfloor>\<^bold>\<diamond>\<^sub>p(Go(I) \<^bold>\<and> Tell(I))\<rfloor>\<^sub>C \<and> \<lfloor>\<^bold>\<diamond>\<^sub>p(Go(I) \<^bold>\<and> \<^bold>\<not>(Tell(I)))\<rfloor>\<^sub>C \<and> \<lfloor>\<^bold>\<not>(Tell(I))\<rfloor>\<^sub>C \<and> \<lfloor>\<^bold>\<diamond>\<^sub>a(Tell(I))\<rfloor>\<^sub>C \<and>  \<lfloor>\<^bold>\<diamond>\<^sub>a(\<^bold>\<not>(Tell(I)))\<rfloor>\<^sub>C)
       \<longrightarrow> (\<lfloor>violated (Go(I))\<rfloor>\<^sub>C \<and> \<lfloor>\<^bold>O\<^sub>a(\<^bold>\<not>(Tell(I)))\<rfloor>\<^sub>C)" 
  using sem_4a sem_4b sem_5b sem_5e B1 B3 B4 by smt

end