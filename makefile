install:
	uv pip install -e .

distribution:
	scripts/build-distribution.sh

public:
	scripts/publish-distribution.sh

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	rm -rf build/ dist/
