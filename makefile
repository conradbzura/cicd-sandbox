install:
	uv pip install -e .

package:
	scripts/build-package.sh

public:
	scripts/publish-package.sh

clean:
	find . -type d -name "__pycache__" -exec rm -rf {} +
	find . -type d -name "*.egg-info" -exec rm -rf {} +
	find . -type d -name ".pytest_cache" -exec rm -rf {} +
	rm -rf build/ dist/
