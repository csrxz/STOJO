CREATE TABLE schools (
  id UUID PRIMARY KEY,
  nome VARCHAR(150) NOT NULL,
  cnpj VARCHAR(18),
  timezone VARCHAR(50) DEFAULT 'America/Sao_Paulo',
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE users (
  id UUID PRIMARY KEY,
  school_id UUID NOT NULL REFERENCES schools(id),
  nome VARCHAR(120) NOT NULL,
  email VARCHAR(120) NOT NULL UNIQUE,
  senha_hash TEXT NOT NULL,
  perfil VARCHAR(30) NOT NULL CHECK (perfil IN ('Administrador','Almoxarifado','Professora','Coordenação')),
  ativo BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE categories (
  id UUID PRIMARY KEY,
  school_id UUID NOT NULL REFERENCES schools(id),
  nome VARCHAR(80) NOT NULL,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE materials (
  id UUID PRIMARY KEY,
  school_id UUID NOT NULL REFERENCES schools(id),
  category_id UUID REFERENCES categories(id),
  nome VARCHAR(180) NOT NULL,
  descricao TEXT,
  foto_url TEXT,
  quantidade_disponivel NUMERIC(12,2) NOT NULL DEFAULT 0,
  estoque_minimo NUMERIC(12,2) NOT NULL DEFAULT 0,
  unidade_medida VARCHAR(20) NOT NULL,
  localizacao_estoque VARCHAR(80),
  codigo_interno VARCHAR(40) NOT NULL,
  qr_code TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE orders (
  id UUID PRIMARY KEY,
  school_id UUID NOT NULL REFERENCES schools(id),
  professora_id UUID NOT NULL REFERENCES users(id),
  coordenacao_id UUID REFERENCES users(id),
  turma_serie VARCHAR(80) NOT NULL,
  observacao TEXT,
  status VARCHAR(20) NOT NULL CHECK (status IN ('Pendente','Em aprovação','Aprovado','Rejeitado','Separando','Entregue')),
  data_solicitacao TIMESTAMP NOT NULL DEFAULT NOW(),
  data_aprovacao TIMESTAMP,
  data_entrega TIMESTAMP
);

CREATE TABLE order_items (
  id UUID PRIMARY KEY,
  order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  material_id UUID NOT NULL REFERENCES materials(id),
  quantidade NUMERIC(12,2) NOT NULL CHECK (quantidade > 0),
  custo_unitario NUMERIC(12,2)
);

CREATE TABLE stock_movements (
  id UUID PRIMARY KEY,
  school_id UUID NOT NULL REFERENCES schools(id),
  material_id UUID NOT NULL REFERENCES materials(id),
  tipo VARCHAR(20) NOT NULL CHECK (tipo IN ('Entrada','Saída','Ajuste manual')),
  quantidade NUMERIC(12,2) NOT NULL,
  usuario_id UUID NOT NULL REFERENCES users(id),
  observacao TEXT,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);

CREATE TABLE audit_logs (
  id UUID PRIMARY KEY,
  school_id UUID NOT NULL REFERENCES schools(id),
  usuario_id UUID REFERENCES users(id),
  acao VARCHAR(120) NOT NULL,
  entidade VARCHAR(50) NOT NULL,
  entidade_id UUID,
  detalhes JSONB,
  created_at TIMESTAMP NOT NULL DEFAULT NOW()
);
