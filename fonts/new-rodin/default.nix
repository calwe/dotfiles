{ lib, fetchzip }:

fetchzip {
    name = "new-rodin";

    url = "https://transfer.sh/FW8eK3/new-rodin.zip";

    sha256 = "GPj0uDkQlx7eb9YGsQ0OKcOIMj6OqhcQi0ZkjgR1K6s=";

    postFetch = ''
        mkdir -p $out/share/fonts
        echo $downloadedFile
        unzip -j $renamed -d $out/share/fonts/opentype
    '';

    meta = with lib; {
        homepage = "";
        description = "Japanese style font";
        license = licenses.ofl;
        platforms = platforms.all;
    };
}