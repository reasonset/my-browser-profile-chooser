webpf_sample() {
	profile="$HOME/profiles/sample" # Profile name or path.
    chi
}

webpf_sample_incognito() {
	cliarg=(--incognito "$cliarg[@]")
	profile="$HOME/profiles/sample"
	chi
}

webpf_sample_falkon() {
    profile="sample"
    flk
}

webpf_sample_fx_profile_name() {
    profile=sample
    (( fx_path_mode=0 ))
    fx
}