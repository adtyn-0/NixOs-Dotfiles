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
    package = pkgs.llama-cpp.override {
      cudaSupport = true;
    };
  };


}
