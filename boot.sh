get_script_dir () {
     SOURCE="${BASH_SOURCE[0]}"
     while [ -h "$SOURCE" ]; do
          DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
          SOURCE="$( readlink "$SOURCE" )" 
          [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
     done
     DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
     echo "$DIR"
}
path=$(get_script_dir)
cd $path/lib/dpdk && meson $path/lib/dpdk_build || exit 1
cd $path/lib/dpdk_build
ninja && sudo ninja install || exit 1
ldconfig || exit 1
cd $path/lib/libutil
make || exit 1
cd $path/src
make
cd $path