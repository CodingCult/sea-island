import { Game } from "./game";
import "./styles.css";

(async () => {
        const game = new Game();
    await game.init();
})();
