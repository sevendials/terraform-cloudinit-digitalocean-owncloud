Create ownCloud server on DigitalOcean using terraform and cloud-init

Download terraform, create a terraform.tfvars with the following content:
```
"db_admin_pass" = "supErsecretdbrootpassword"
"db_pass" = "supErsecretownclouddbuserpassword"
"do_token" = "myverylongdigitaloceantoken"
"do_ssh_key" = "mydigitaloceansshkeyidorfingerprint"
```
and run:
```
terraform apply
```
Your ownCloud server will appear at this address:
$(terraform output address)
