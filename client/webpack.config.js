import path from "path";
import HtmlWebpackPlugin from "html-webpack-plugin";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

export default (_env, argv) => {
    const isProduction = argv.mode === "production";

    return {
        entry: "./src/index.ts",
        mode: isProduction ? "production" : "development",
        module: {
            rules: [
                {
                    test: /\.ts$/,
                    use: "ts-loader",
                    exclude: /node_modules/,
                },
                {
                    test: /\.css$/,
                    use: ["style-loader", "css-loader"],
                    exclude: /node_modules/,
                },
                {
                    test: /\.(png|svg)$/i,
                    type: "asset/resource",
                },
            ],
        },
        resolve: {
            extensions: [".ts", ".js"],
        },
        output: {
            filename: "bundle.js",
            path: path.resolve(__dirname, "dist"),
        },
        plugins: [
            new HtmlWebpackPlugin({
                template: "src/index.html",
            }),
        ],
        devServer: {
            static: path.join(__dirname, "public"),
            compress: true,
            port: 3000,
        },
    };
};
