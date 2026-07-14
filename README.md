# Equivalência entre Noções de Indução - PAA 2026/1

Este repositório contém a formalização em Coq/Rocq da equivalência lógica entre três noções de indução sobre os números naturais (`nat`):
1.  **PIM** (Princípio da Indução Matemática - indução simples)
2.  **PIF** (Princípio da Indução Forte)
3.  **PBO** (Princípio da Boa Ordenação)

Trabalho prático desenvolvido para a disciplina **Projeto e Análise de Algoritmos (2026/1)** da **Universidade de Brasília (UnB)**.

## Integrantes
*   **Cecíllia Carvalho de Santana** - 17/0008002
*   **Guilherme Praxedes Franco** - 18/0136780

## Vídeo da Apresentação:

- https://www.youtube.com/watch?v=48FExCprX8s

## Estrutura do Repositório
*   `inducaoequivalente.v`: Contém as definições dos princípios de indução e as provas de equivalência (`PIM_equiv_PIF`, `PBO_equiv_PIM` e `PBO_equiv_PIF`).
*   `_CoqProject`: Arquivo de mapeamento lógico para o compilador do Coq.
*   `Makefile`: Script auxiliar para compilação local das provas.
*   `relatorio.md`: Documentação técnica do projeto com explicações matemáticas e os ajustes de compilação aplicados sobre o template original.
