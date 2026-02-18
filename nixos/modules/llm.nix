{ config , pkgs, ...}:

{
  # Ollama configuration with CUDA Support
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  # Llama.cpp configuration cause why not?
  # serivces.llama-cpp = {
  # enable = true;
  # package = pkgs.llama-cpp;
  # };

  # Packages Cause apparently service doesn't work
  environment.systemPackages = with pkgs; [
    (llama-cpp.override {
      cudaSupport = true;
    })

  ];

}
