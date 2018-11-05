# Clear any old environment that may conflict.
for key in $( set | awk '{FS="="}  /^OS_/ {print $1}' ); do unset $key ; done
export OS_USERNAME={{ item.name }}
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_DOMAIN_NAME=Default
export OS_BAREMETAL_API_VERSION=1.34
export NOVA_VERSION=1.1
export OS_PROJECT_NAME={{ item.project }}
export OS_PASSWORD="{{ lookup('file', 'testdata/credentials/' + item.name + '-password') }}"
export OS_NO_CACHE=True
export COMPUTE_API_VERSION=1.1
export no_proxy={{ lookup('env', 'no_proxy') }}
export OS_VOLUME_API_VERSION=3
export OS_CLOUDNAME=overcloud-{{ item.name }}
export OS_AUTH_URL={{ hostvars[groups.controller.0].keystone_endpoint }}
export IRONIC_API_VERSION=1.34
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
export OS_AUTH_TYPE=password
export PYTHONWARNINGS="ignore:Certificate has no, ignore:A true SSLContext object is not available"

# Add OS_CLOUDNAME to PS1
if [ -z "${CLOUDPROMPT_ENABLED:-}" ]; then
    export PS1=${PS1:-""}
    export PS1=\${OS_CLOUDNAME:+"(\$OS_CLOUDNAME)"}\ $PS1
    export CLOUDPROMPT_ENABLED=1
fi
