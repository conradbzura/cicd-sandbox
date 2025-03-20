install:
	uv pip install -e .

distribution:
	scripts/build-package.sh

public:
	scripts/publish-package.sh

distribution-dryrun:
	@scripts/publish.sh

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	rm -rf build/ dist/
