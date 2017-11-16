#!/usr/bin/env bats

#Test generate_index.sh
setup() {
	BATS_TMPDIR="$BATS_TEST_DIRNAME/TEMP"
export BATS_TMPDIR
	cd "$BATS_TEST_DIRNAME"
        cd ..
	source ./config/config.conf
	mkdir "$BATS_TMPDIR"
        mkdir "$html_path"
	cd "$BATS_TEST_DIRNAME"
        cd ..
	bash install.sh
}

teardown() {
        rm -dfr "$install_path/temp"
        rm -dfr "$BATS_TMPDIR"
}


compare_indexhtml() {
if [[ -z $(diff --suppress-common-lines --side-by-side "$html_path/index.html" "./tests/test/$indexname.html" | grep --invert-match $(date +%d.%m.%Y))  ]];then
echo "indexhtml_success"
else
echo "indexhtml_fail"
 fi
}


#Test manual input - text entry
@test "Manual Input: text" {
	#Simulate manual imput
        echo -ne "URL \n TEXT \n TAG1, TAG2" | bash input_entry.sh

	#Compare generated index.html with master	
	indexname=index_manual_text
	run compare_indexhtml

	[ "$output" == "indexhtml_success" ]
}
#Test manual input - youtube entry
@test "Manual Input: youtube" {
        #Simulate manual imput
        echo -ne "https://www.youtube.com/watch?v=Fsm1_iWzf8E \n TEXT \n TAG1, TAG2" | bash input_entry.sh

        #Compare generated index.html with master       
        indexname=index_manual_youtube
        run compare_indexhtml

        [ "$output" == "indexhtml_success" ]
}
