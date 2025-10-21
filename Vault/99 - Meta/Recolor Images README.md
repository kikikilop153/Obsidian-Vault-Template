# Recolor Images (luminance → alpha) — Guia rápido

Este documento explica a implementação do pipeline de recoloração de imagens adicionada ao snippet `Notebook Backgrounds.css`.

Resumo da pipeline

- Luminance → Alpha: um filtro SVG embutido converte a luminância dos pixels numa máscara alpha.
- Composição: a máscara resultante é composta com a alpha original da imagem para preservar transparências.
- Colorização: aplicamos em seguida os filtros CSS definidos em `--image-effect` para colorizar a imagem com a cor/accent atual.
- Inversão opcional: por padrão raster images recebem `invert(1)` antes da conversão para que tinta escura (preto) vire opaca na máscara. SVGs pulam a inversão por padrão.

Onde está a configuração

- Arquivo de CSS: `.obsidian/snippets/Notebook Backgrounds.css`
- Classe principal: `.recolor-images`

Como usar

- Para recolorir imagens numa nota, aplique a classe `recolor-images` no container (por exemplo, no elemento da página no Obsidian). O snippet aplica o pipeline automaticamente às imagens dentro do container.

Controles e personalização

- `--image-effect` — existe por página/pen color. Ajuste esta variável para alterar a cor final (já contém filtros como `invert(...) sepia(...) hue-rotate(...)` etc.).
- `--recolor-invert` — controla a etapa de inversão aplicada antes do pipeline. Padrão: `invert(1)`.
  - Ex.: para desativar a inversão globalmente em um seletor: `:root { --recolor-invert: none; }` ou para uma página específica:

```css
.page-blueprint { --recolor-invert: none; }
```

Excalidraw (ou SVGs que não devem ser invertidos)

- O snippet já aplica `--svg-luminance-alpha` + `--image-effect` a `svg` dentro de `.recolor-images`, mas sem aplicar `--recolor-invert`.
- Se você exporta Excalidraw como SVG ou usa SVGs vetoriais onde a inversão quebra a leitura, mantenha-os como SVG ou force `--recolor-invert: none` no seletor apropriado.

Exemplos práticos

- Desabilitar inversão apenas para Excalidraw (supondo que os SVGs tenham a classe `.excalidraw`):

```css
.recolor-images .excalidraw { --recolor-invert: none; }
```

- Forçar recolor sem inversão em todas as imagens de um tipo de página:

```css
.page-white .recolor-images img { filter: var(--svg-luminance-alpha) var(--image-effect); }
```

Notas finais

- O filtro SVG está embutido como data URL para que funcione sem arquivos adicionais.
- Se quiser ajustar o comportamento do filtro SVG (por exemplo, inverter a função luminance usada), me diga e eu adiciono variantes ou uma versão externa do SVG para edição.

---

 Se quiser, eu posso também:
 - Adicionar um pequeno snippet de demonstração (HTML) com imagens de exemplo dentro do repositório.
 - Gerar variantes de `--image-effect` predefinidas para casos comuns (dark-ink-on-white, light-ink-on-dark, etc.).

 ## Try it (quick)

 1. Ative os snippets `Notebook Backgrounds.css` e `Recolor Variants.css` nas configurações do Obsidian (Appearance → CSS snippets).
 2. Abra `Vault/99 - Meta/Recolor Demo.md`.
 3. Tente os presets aplicando classes no container (ex.: add `recolor-variant-blueprint` to the surrounding div) ou edite `--recolor-invert` para `none` para SVGs que não devem ser invertidos.

 ## Examples

 ```css
 .recolor-images.recolor-variant-blueprint { }
 .recolor-images .excalidraw { --recolor-invert: none; }
 ```

Diga qual próximo passo prefere.

## Arquivos de demonstração e presets

- Nota de demonstração: `Vault/99 - Meta/Recolor Demo.md` — contém um SVG inline e uma imagem bitmap de exemplo dentro de um container `.recolor-images` para testar rapidamente o efeito.
- Snippet de presets: `Vault/.obsidian/snippets/Recolor Variants.css` — contém variantes prontas de `--image-effect` (blueprint, green, dark-ink) e uma classe helper `.recolor-no-invert` para desabilitar a inversão.

Ative ambos os snippets no Obsidian e abra a nota de demo para ver o efeito. Substitua as imagens na nota por imagens reais para testes mais representativos.