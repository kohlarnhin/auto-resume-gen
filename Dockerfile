# 使用 Node.js 镜像作为基础镜像
FROM node:20-alpine

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json 到工作目录
COPY package*.json ./

# 安装项目依赖
RUN npm install

# 将所有项目文件复制到工作目录
COPY . .

# 构建 Vue 项目
RUN npm run build

# 暴露容器的端口
EXPOSE 80

# 定义容器启动时执行的命令
CMD ["npm", "run", "dev"]
