# -----------------------------------------------------------------------------
# Valores padrão do unit S3
# O terragrunt.stack.hcl do live pode sobrescrever qualquer um desses valores
# -----------------------------------------------------------------------------

name                   = "meu-bucket"    # obrigatório — sem padrão real
versioning             = true
force_destroy          = false
expire_noncurrent_days = 90
