cite about-alias
about-alias 'openstack aliases'

# Openstack Command
alias osp='source ~/openstack/3virtadmin_p9'
alias osppl='openstack project list --sort-column Name | egrep -v $(reg_proj_stack)'
alias osph='openstack hypervisor list --sort-column "Hypervisor Hostname"'
alias osphs='openstack hypervisor show -c service_host $1'
alias noval='nova limits --tenant $1'
alias crbac='openstack network rbac create --type network --action access_as_shared --project service --target-project $1 external'
alias ospmsv='curl "http://169.254.169.254/openstack/latest/meta_data.json"'
