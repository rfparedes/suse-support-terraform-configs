# GCP Settings
gcp_region_1     = "us-east1"
gcp_zone_1       = "us-east1-b"
gcp_auth_file    = "../../authfiles/suse-repro2-9a0b717a5f25.json"
ssh_keys	 = "rich:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC8vQVGcwfKDT32QdWb9+PVVzAF1NVEUhOPmSbH7n8w2bIyGw7voUsEE9IdhmKr2qulnKJVRHd7XfEzBj0KJFTlkfSFEJHF/5TO4/oe4mEZkVE1H9XdnT8DsQ1Ytr+ewuRF9e5OKseQEZqPrINti4AzZ5McoS20McNNOiJCzzsn8n9NuJXBcnrBsmdj0wcJQodl3rV1v3w+rEuoosrTUqkoEn8wzySlSR3US9iYK6R/yeylVBJiPA5rCjox3SkAqsaxzfTaCNAfl5hOc+xRRU/+wIE0slro65HfwQDSJfqehJmeJ4EARInoxZabc061hVdLx2/JEIyawMvA/FDa2Qjd"

# GCP Network
private_subnet_cidr_1 = "192.168.111.0/24"

# Application Definition
app_name	= "repro1"
app_environment = "test"
app_project     = "suse-repro2"
srv_acct = "terraform2@suse-repro2.iam.gserviceaccount.com"
