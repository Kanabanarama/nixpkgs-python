# generated using pypi2nix tool (version: 1.8.1)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -W https://travis.garbas.si/wheels_cache/ -v -V 3.5 -O ../overrides.nix -r requirements.txt
#

{ pkgs ? import <nixpkgs> {}
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python35;
    # patching pip so it does not try to remove files when running nix-shell
    overrides =
      self: super: {
        bootstrapped-pip = super.bootstrapped-pip.overrideDerivation (old: {
          patchPhase = old.patchPhase + ''
            sed -i \
              -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"  \
              -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"  \
                $out/${pkgs.python35.sitePackages}/pip/req/req_install.py
          '';
        });
      };
  };

  commonBuildInputs = [];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreter = pythonPackages.buildPythonPackage {
        name = "python35-interpreter";
        buildInputs = [ makeWrapper ] ++ (builtins.attrValues pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter} \
              $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "
              (builtins.attrValues pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -x "$prog" ] && [ -f "$prog" ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable} \
              python3
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };
    in {
      __old = pythonPackages;
      inherit interpreter;
      mkDerivation = pythonPackages.buildPythonPackage;
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (
          drv.drvAttrs // f drv.drvAttrs // { meta = drv.meta; }
        );
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {
    "Jinja2" = python.mkDerivation {
      name = "Jinja2-2.10";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/56/e6/332789f295cf22308386cf5bbd1f4e00ed11484299c5d7383378cf48ba47/Jinja2-2.10.tar.gz"; sha256 = "f84be1bb0040caca4cea721fcbbbbd61f9be9464ca236387158b0feea01914a4"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."MarkupSafe"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://jinja.pocoo.org/";
        license = licenses.bsdOriginal;
        description = "A small but fast and easy to use stand-alone template engine written in pure python.";
      };
    };

    "MarkupSafe" = python.mkDerivation {
      name = "MarkupSafe-1.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/4d/de/32d741db316d8fdb7680822dd37001ef7a448255de9699ab4bfcbdf4172b/MarkupSafe-1.0.tar.gz"; sha256 = "a6be69091dac236ea9c6bc7d012beab42010fa914c459791d627dad4910eb665"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/pallets/markupsafe";
        license = licenses.bsdOriginal;
        description = "Implements a XML/HTML/XHTML Markup safe string for Python";
      };
    };

    "Pygments" = python.mkDerivation {
      name = "Pygments-2.2.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/71/2a/2e4e77803a8bd6408a2903340ac498cb0a2181811af7c9ec92cb70b0308a/Pygments-2.2.0.tar.gz"; sha256 = "dbae1046def0efb574852fab9e90209b23f556367b5a320c0bcb871c77c3e8cc"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pygments.org/";
        license = licenses.bsdOriginal;
        description = "Pygments is a syntax highlighting package written in Python.";
      };
    };

    "Unidecode" = python.mkDerivation {
      name = "Unidecode-1.0.22";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/9d/36/49d0ee152b6a1631f03a541532c6201942430060aa97fe011cf01a2cce64/Unidecode-1.0.22.tar.gz"; sha256 = "8c33dd588e0c9bc22a76eaa0c715a5434851f726131bd44a6c26471746efabf5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "";
        license = licenses.gpl2Plus;
        description = "ASCII transliterations of Unicode text";
      };
    };

    "blinker" = python.mkDerivation {
      name = "blinker-1.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/1b/51/e2a9f3b757eb802f61dc1f2b09c8c99f6eb01cf06416c0671253536517b6/blinker-1.4.tar.gz"; sha256 = "471aee25f3992bd325afa3772f1063dbdbbca947a041b8b89466dc00d606f8b6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/blinker/";
        license = licenses.mit;
        description = "Fast, simple object-to-object and broadcast signaling";
      };
    };

    "docutils" = python.mkDerivation {
      name = "docutils-0.14";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/84/f4/5771e41fdf52aabebbadecc9381d11dea0fa34e4759b4071244fa094804c/docutils-0.14.tar.gz"; sha256 = "51e64ef2ebfb29cae1faa133b3710143496eca21c530f3f71424d77687764274"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docutils.sourceforge.net/";
        license = licenses.publicDomain;
        description = "Docutils -- Python Documentation Utilities";
      };
    };

    "feedgenerator" = python.mkDerivation {
      name = "feedgenerator-1.9";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/eb/02/7069b3dbc6ea92f034e07f9f9adc2193cd02d1aedf2cf9ec71150102a964/feedgenerator-1.9.tar.gz"; sha256 = "5ae05daa9cfa47fa406ee4744d0b7fa1c8a05a7a47ee0ad328ddf55327cfb106"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."pytz"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/getpelican/feedgenerator";
        license = licenses.bsdOriginal;
        description = "Standalone version of django.utils.feedgenerator";
      };
    };

    "ghp-import" = python.mkDerivation {
      name = "ghp-import-0.5.5";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/bd/95/27cb11b5d09643c2756f04a1412b0d62aadeb0b909564f85122270c4097c/ghp-import-0.5.5.tar.gz"; sha256 = "3e924ea720e4e1f82d56753db2154bfb86067472c5830732159c3a4c4fbc75d7"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/davisp/ghp-import";
        license = "Tumbolia Public License";
        description = "Copy your docs directly to the gh-pages branch.";
      };
    };

    "livereload" = python.mkDerivation {
      name = "livereload-2.5.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f7/1b/aa5fb8c59fc683bbabdfdcfd4455673d07ac05f391d6b1244ad204b33ebc/livereload-2.5.2.tar.gz"; sha256 = "dd4469a8f5a6833576e9f5433f1439c306de15dbbfeceabd32479b1123380fa5"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
      self."tornado"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/lepture/python-livereload";
        license = licenses.bsdOriginal;
        description = "Python LiveReload is an awesome tool for web developers";
      };
    };

    "pelican" = python.mkDerivation {
      name = "pelican-3.7.1";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/d0/9e/c5cf3f7e98b84ac666422d7f6707cc415d4c96247c266377c0ed5a489f49/pelican-3.7.1.tar.gz"; sha256 = "2a5347fe47464ee743bff99b6e81d1b5823f2e70e7be5bd6ed66a5bdd5f3578b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."Jinja2"
      self."Pygments"
      self."Unidecode"
      self."blinker"
      self."docutils"
      self."feedgenerator"
      self."python-dateutil"
      self."pytz"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://getpelican.com/";
        license = licenses.agpl3;
        description = "Static site generator supporting reStructuredText and Markdown source content.";
      };
    };

    "python-dateutil" = python.mkDerivation {
      name = "python-dateutil-2.7.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/c5/39/4da7c2dbc4f023fba5fb2325febcadf0d0ce0efdc8bd12083a0f65d20653/python-dateutil-2.7.2.tar.gz"; sha256 = "9d8074be4c993fbe4947878ce593052f71dac82932a677d49194d8ce9778002e"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://dateutil.readthedocs.io";
        license = licenses.bsdOriginal;
        description = "Extensions to the standard Python datetime module";
      };
    };

    "pytz" = python.mkDerivation {
      name = "pytz-2018.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/10/76/52efda4ef98e7544321fd8d5d512e11739c1df18b0649551aeccfb1c8376/pytz-2018.4.tar.gz"; sha256 = "c06425302f2cf668f1bba7a0a03f3c1d34d4ebeef2c72003da308b3947c7f749"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pythonhosted.org/pytz";
        license = licenses.mit;
        description = "World timezone definitions, modern and historical";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.11.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"; sha256 = "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/six/";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "smartypants" = python.mkDerivation {
      name = "smartypants-2.0.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/09/dd/08848ea21422a585ecd2dd32c032fd8f75f0f8345225b455f3bf9e5a0feb/smartypants-2.0.0.tar.gz"; sha256 = "7812353a32022699a1aa8cd5626e01c94a946dcaeedaee2d0b382bae4c4cbf36"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://bitbucket.org/livibetter/smartypants.py";
        license = licenses.bsdOriginal;
        description = "Python with the SmartyPants";
      };
    };

    "tornado" = python.mkDerivation {
      name = "tornado-5.0.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/cf/d1/3be271ae5eba9fb59df63c9891fdc7d8044b999e8ac145994cdbfd2ae66a/tornado-5.0.2.tar.gz"; sha256 = "1b83d5c10550f2653380b4c77331d6f8850f287c4f67d7ce1e1c639d9222fbc7"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.tornadoweb.org/";
        license = "License :: OSI Approved :: Apache Software License";
        description = "Tornado is a Python web framework and asynchronous networking library, originally developed at FriendFeed.";
      };
    };

    "typogrify" = python.mkDerivation {
      name = "typogrify-2.0.7";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/8a/bf/64959d6187d42472acb846bcf462347c9124952c05bd57e5769d5f28f9a6/typogrify-2.0.7.tar.gz"; sha256 = "8be4668cda434163ce229d87ca273a11922cb1614cb359970b7dc96eed13cb38"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."smartypants"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/mintchaos/typogrify";
        license = licenses.bsdOriginal;
        description = "Filters to enhance web typography, including support for Django & Jinja templates";
      };
    };
  };
  localOverridesFile = ./requirements_override.nix;
  overrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [
        (import ../overrides.nix { inherit pkgs python ; })
  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [overrides] else [] ) ++ commonOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )