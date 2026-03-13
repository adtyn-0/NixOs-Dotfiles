{ config , pkgs, ...}:

{
  # Ollama configuration with CUDA Support
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
  };

  # Llama.cpp configuration cause why not?
  services.llama-cpp = {
  enable = true;
  package = pkgs.llama-cpp;
  model = "/home/adtyn/models/gemma-3-4b-it-q4_0.gguf";
  };

  # Packages Cause apparently service doesn't work
  environment.systemPackages = with pkgs; [
    (llama-cpp.override {
      cudaSupport = true;
    })

  ];

}
