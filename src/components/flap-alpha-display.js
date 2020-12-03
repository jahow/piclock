const CELL_SIZE = 12;
const CELL_GUTTER = 2;

class FlapAlphaDisplay extends HTMLElement {
  constructor() {
    super();

    this._colCount = parseInt(this.getAttribute('width-cell'));
    this._rowCount = parseInt(this.getAttribute('height-cell'));

    this._text = '';

    this._canvas = document.createElement('canvas');
    this._canvas.width =
      this._colCount * CELL_SIZE + (this._colCount + 1) * CELL_GUTTER;
    this._canvas.height =
      this._rowCount * CELL_SIZE + (this._rowCount + 1) * CELL_GUTTER;
    this.appendChild(this._canvas);
  }

  connectedCallback() {
    this.render();
  }

  get text() {
    return this._text;
  }

  set text(value) {
    this._text = value;
    this.render();
  }

  render() {
    const ctx = /** @type {CanvasRenderingContext2D} */ this._canvas.getContext(
      '2d'
    );
    ctx.fillStyle = '#1f1f1f';
    ctx.fillRect(0, 0, this._canvas.width, this._canvas.height);

    ctx.fillStyle = '#3e3e3e';
    for (let i = 0; i < this._colCount; i++) {
      for (let j = 0; j < this._rowCount; j++) {
        ctx.fillRect(
          i * (CELL_SIZE + CELL_GUTTER) + CELL_GUTTER,
          j * (CELL_SIZE + CELL_GUTTER) + CELL_GUTTER,
          CELL_SIZE,
          CELL_SIZE
        );
      }
    }
  }
}

customElements.define('flap-alpha-display', FlapAlphaDisplay);
