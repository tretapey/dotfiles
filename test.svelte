<script>
  let count = 0;

  function increment() {
    count += 1;
  }
</script>

<style>
  button {
    background-color: blue;
    color: white;
    padding: 10px;
  }
</style>

<main>
  <h1>Hello Svelte!</h1>
  <button on:click={increment}>
    Count: {count}
  </button>
</main>
