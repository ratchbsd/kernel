# Compile Documentation - Using our custom Documentation Language.

# Variables
DOCS_SRC_DIR = Documentation/src
DOCS_DIR = Documentation/build
PYTHON_COMPILER = ldoc.py
PYTHON_COMPILER_PATH = doc-compiler
PYTHON = python3

compile_docs:
	@echo "Generating the documentation..."
	make fetch_py_compiler
	./$(PYTHON_COMPILER_PATH)/$(PYTHON_COMPILER) build $(DOCS_SRC_DIR) -o $(DOCS_DIR),

fetch_py_compiler:
	@echo "Checking if Python compiler is already fetched..."
	@if [ ! -f $(PYTHON_COMPILER_PATH)/$(PYTHON_COMPILER) ]; then \
		echo "Python compiler not found, fetching..."; \
		git clone https://github.com/ternicincl/libredoc-language.git ldoc; \
		mkdir -p $(PYTHON_COMPILER_PATH); \
		cp ldoc/ldoc.py ./$(PYTHON_COMPILER_PATH)/; \
		cp -r ldoc/templates ./$(PYTHON_COMPILER_PATH)/; \
		rm -rf ldoc; \
	else \
		echo "Python compiler already exists, skipping fetch."; \
	fi

clean_docs:
	@echo "Cleaning up the generated files..."
	rm -rf $(DOCS_DIR)/build
