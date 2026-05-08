# terragrunt-infrastructure-catalog

Catálogo de units de infraestrutura. Mantido pelo time de Platform.

---

## Como funciona

```
terragrunt.stack.hcl (live)   ← Dev declara o recurso com values
        ↓ referencia
units/aws/s3/terragrunt.hcl   ← Platform define como criar
        ↓ referencia
terraform-aws-modules/s3-bucket  ← módulo oficial
        ↓
Recurso criado na AWS
```

---

## Units disponíveis

| Unit | Provider | Módulo base | Status |
|------|----------|-------------|--------|
| s3 | AWS | terraform-aws-modules/s3-bucket v4.2.1 | ✅ Disponível |
| rds | AWS | terraform-aws-modules/rds | 🚧 Em breve |
| eks | AWS | terraform-aws-modules/eks | 🚧 Em breve |
| route53 | AWS | terraform-aws-modules/route53 | 🚧 Em breve |

---

## Como adicionar um novo unit (Platform)

1. Crie a pasta `units/aws/<recurso>/`
2. Adicione o `terragrunt.hcl` com os inputs vindos de `values.all`
3. Adicione o `terragrunt.values.hcl` com os valores padrão
4. Abra PR — CI valida automaticamente
5. Após merge, crie a tag:

```bash
git tag v1.1.0
git push origin v1.1.0
```

---

## Estrutura

```
terragrunt-infrastructure-catalog/
│
├── units/
│   └── aws/
│       └── s3/
│           ├── terragrunt.hcl        # lógica do unit — Platform mantém
│           └── terragrunt.values.hcl # valores padrão + documentação
│
└── .github/
    └── workflows/
        └── validate.yml
```