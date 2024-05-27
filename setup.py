from setuptools import setup, find_packages

setup(
    name="flusionfind",
    version="1.0",
    packages=find_packages(),
    entry_points={
        "console_scripts": [
            "flusionfind = flusionfind.cli:main",
        ],
    },
    install_requires=[
        "click",
    ],
    author="Wilson Jose da Silva",
    description="Monta genomas de influenza usando IRMA, GenoFLU e Nexclade.",
    long_description=open("README.md").read(),
    long_description_content_type="text/markdown",
    url="https://github.com/WallauBioinfo/FlusionFind",
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires=">=3.6",
)
