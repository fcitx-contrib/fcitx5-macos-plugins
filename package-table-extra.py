import os

plugins = {
    "array": [
        "array30",
        "array30-large",
    ],
    "boshiamy": [
        "boshiamy"
    ],
    "cangjie": [
        "cangjie5",
        "cangjie3",
        "cangjie-large",
        "scj6"
    ],
    "cantonese": [
        "cantonese",
        "cantonhk",
        "jyutping-table"
    ],
    "quick": [
        "quick5",
        "quick3",
        "quick-classic",
        "easy-large"
    ],
    "stroke": [
        "t9",
        "stroke5"
    ],
    "wu": [
        "wu"
    ],
    "wubi86": [
        "wubi-large"
    ],
    "wubi98": [
        "wubi98",
        "wubi98-single",
        "wubi98-large",
        "wubi98-pinyin"
    ],
    "zhengma": [
        "zhengma",
        "zhengma-large",
        "zhengma-pinyin"
    ]
}


def ensure(command: str):
    if os.system(command) != 0:
        exit(1)


build_dir = os.getcwd()

# split table-extra to plugins and keep directory structures so the package script can be reused
for plugin, ims in plugins.items():
    ensure(f"rm -rf {plugin}")
    ensure(f"mkdir -p {plugin}/" + "tmp/data/share/fcitx5/{inputmethod,table}")
    ensure(f"mkdir -p {plugin}/tmp/fcitx5")

    # equivalent to f5m_split_data
    for im in ims:
        ensure(f"mv table-extra/tmp/fcitx5/share/fcitx5/inputmethod/{im}.conf {plugin}/tmp/data/share/fcitx5/inputmethod")
        ensure(f"mv table-extra/tmp/fcitx5/share/fcitx5/table/{im}.main.dict {plugin}/tmp/data/share/fcitx5/table")

    os.chdir(f"{plugin}/tmp/fcitx5")
    ensure(f"python {build_dir}/../generate-descriptor.py {ims[0]}")
    os.chdir("../data")
    ensure(f"tar cjvf {build_dir}/{plugin}-any.tar.bz2 *")
    os.chdir(build_dir)
