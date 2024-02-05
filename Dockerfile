FROM nvidia/cuda:12.1.0-devel-ubuntu18.04

# 安装必要的包和依赖项
RUN apt-get update && apt-get install -y \
    software-properties-common \
    && add-apt-repository ppa:ubuntu-toolchain-r/test \
    && apt-get update && apt-get install -y \
    gcc-6 \
    g++-6 \
    cmake \
    git \
    wget \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 \
                            --slave /usr/bin/g++ g++ /usr/bin/g++-6 \
    && update-alternatives --config gcc

# 验证安装的版本
RUN gcc --version
RUN cmake --version
RUN git --version
RUN wget --version

# 设置工作目录
WORKDIR /workspace

COPY . /workspace
RUN mkdir -p /workspace/build
RUN cd /workspace/build && cmake .. && make -j$(nproc)

# 设置默认命令或入口点
CMD ["/bin/bash"]