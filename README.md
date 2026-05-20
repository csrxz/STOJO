# STOJO

Aplicativo web responsivo em **pt-BR** para controle de estoque escolar multi-escola.

## Como executar

Basta abrir `index.html` no navegador.

## Funcionalidades implementadas

- Login com e-mail/senha e recuperação de senha
- Dashboard com KPIs, movimentações e gráfico de consumo
- CRUD visual de materiais
- Catálogo em cards com busca/filtro/ordenação/paginação (UI)
- Solicitação de materiais por professora
- Aprovação de pedidos por coordenação/almoxarifado
- Controle de estoque (entrada/saída/ajuste)
- Relatórios gerenciais (UI)
- Estrutura de multi-escola
- Auditoria de ações
- Busca automática de imagens com query otimizada e galeria de seleção
- Upload manual e captura via câmera (quando suportado)

## Banco de dados

Arquivo `schema.sql` contém entidades:
`schools`, `users`, `categories`, `materials`, `orders`, `order_items`, `stock_movements`, `audit_logs`.
