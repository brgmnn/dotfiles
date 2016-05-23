function fish-export --description "Convert bash exports to fish exports."
    command sed -e 's/export/set -x/' -e 's/=/ /'
end
