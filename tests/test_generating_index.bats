#!/usr/bin/env bats

#Test generate_index.sh
setup() {
	cd $BATS_TEST_DIRNAME
        cd ..
	source ./config/config.conf
        cd "$html_path"
	rm -dRf ./*
	sleep 1
        cd $BATS_TEST_DIRNAME
        cd ..
	bash install.sh
	sleep 1
}
@test "Publish text-only entry" {
 source ./config/config.conf
        echo -ne "URL \n TEXT \n TAG1, TAG2" | bash input_entry.sh
sleep 1

comparison=$(diff --suppress-common-lines --side-by-side "$html_path/index.html" "$BATS_TEST_DIRNAME/test/index.html")
if [[ -n $( $comparison | grep -v $(date +%d.%m.%Y) )   ]];then
echo "nicht gleich"
[ $status -ne 1 ]
else
echo "gleich"
[ $status -ne 0 ]
fi
}

