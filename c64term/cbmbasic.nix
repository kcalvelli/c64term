{
  lib,
  stdenv,
  fetchFromGitHub,
}:

stdenv.mkDerivation rec {
  pname = "cbmbasic";
  version = "unstable-2022-12-18";

  src = fetchFromGitHub {
    owner = "mist64";
    repo = "cbmbasic";
    rev = "352a313313dd0a15a47288c8f8031b54ac8c92a2";
    hash = "sha256-aA/ivRap+aDd2wi6KWXam9eP/21lOn6OWTeZ4i/S9Bs=";
  };

  # Fix C23 compatibility and POSIX function issues
  postPatch = ''
    # Replace the hardcoded CFLAGS in Makefile with C11-compatible flags
    # Add _DEFAULT_SOURCE to enable POSIX functions like localtime_r and settimeofday
    substituteInPlace Makefile \
      --replace-fail "CFLAGS=-Wall -O3" "CFLAGS=-std=c11 -D_DEFAULT_SOURCE -Wall -O3"
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin
    install -m755 cbmbasic $out/bin/
    runHook postInstall
  '';

  meta = with lib; {
    description = "Portable version of Commodore's version of Microsoft BASIC 6502 as found on the Commodore 64";
    homepage = "https://github.com/mist64/cbmbasic";
    license = licenses.bsd2;
    maintainers = [ ];
    platforms = platforms.unix;
    mainProgram = "cbmbasic";
  };
}
