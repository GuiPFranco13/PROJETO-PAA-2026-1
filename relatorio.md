# Projeto de Formalização — PAA (2026/1)

**Tema 5: Equivalência entre diferentes noções de indução**

**Alunos:**
*   Cecíllia Carvalho de Santana — 17/0008002
*   Guilherme Praxedes Franco — 18/0136780

---

## 1. Introdução

Este trabalho apresenta a formalização no assistente de provas Coq/Rocq da equivalência lógica entre três noções de indução sobre o conjunto de números naturais:
*   **PIM** (Princípio da Indução Matemática - indução simples)
*   **PIF** (Princípio da Indução Forte)
*   **PBO** (Princípio da Boa Ordenação)

O código-fonte com todas as definições e teoremas está localizado em `src/ind_equiv.v`.

## 2. Estratégia de Prova

Para fechar a equivalência lógica entre os três princípios, a seguinte cadeia de implicações foi demonstrada:
1.  `PIM -> PIF`: Provada utilizando um lema de generalização intermediário `Haux : forall n, forall m, m <= n -> Q m` por indução simples sobre `n`, e instanciando com `m = n` para obter `Q n`.
2.  `PIF -> PIM`: Reduzida diretamente à indução forte. O passo indutivo do `PIM` (`P k -> P (S k)`) é provado aplicando a hipótese do `PIF` no predecessor `k`.
3.  `PBO -> PIM`: Provada por contradição utilizando lógica clássica (`classic` da biblioteca `Classical`). Caso exista um contraexemplo, o `PBO` nos garante o menor deles, `m`. Mostra-se por contradição aritmética (`lia`) que `m` não pode ser `0` nem sucessor `S k`.
4.  `PIM -> PBO` (via `PIF`): Provado a partir da equivalência da indução forte para retroceder recursivamente nas propriedades de minimidade.

Os teoremas principais (`PBO_equiv_PIM` e `PBO_equiv_PIF`) foram fechados através da composição direta destas implicações usando projeções lógicas (`proj1` e `proj2`), evitando repetir as mesmas provas.

## 3. Correção de Erros no Enunciado/Template

Durante o desenvolvimento do projeto, identificamos duas imprecisões no template original disponibilizado:

1.  **Ambiguidade de unificação na aplicação do `HPIF`**:
    Na prova de `PBO`, o Coq falhava em aplicar `apply HPIF` de forma implícita por não conseguir unificar o predicado dependente.
    *   **Correção**: Instanciamos o predicado explicitamente na chamada:
        ```coq
        apply (HPIF (fun k => P k -> exists m, P m /\ forall x, x < m -> ~ P x)).
        ```
2.  **Limitação do `apply` em equivalências `<->`**:
    O comando `apply PIM_equiv_PIF` apresentava falhas de unificação de tipos porque as assinaturas estruturais externas de `PIM` e `PIF` são sintaticamente idênticas.
    *   **Correção**: Substituímos pelo uso explícito de projeções de equivalência (`proj1` e `proj2`):
        ```coq
        apply (proj1 PIM_equiv_PIF HPIM).
        ```

## 4. Ambiente Utilizado

*   **Compilador**: Rocq/Coq (versão 9.1.1)
*   **Bibliotecas**: `Arith`, `Lia` (aritmética linear automática) e `Classical` (lógica clássica).
