<script lang="ts">
  import { onMount } from "svelte";

  const APP_LINK_BASE = "https://kupi.msbx.dev/auth/callback";
  const AUTO_REDIRECT_DELAY_MS = 250;
  const AUTO_REDIRECT_STORAGE_KEY = "kupi_auth_callback_auto_attempted";

  let hasAttemptedOpen = $state(false);
  let opening = $state(true);

  function buildAppLinkUrl() {
    if (typeof window === "undefined") return APP_LINK_BASE;
    const { search, hash } = window.location;
    return `${APP_LINK_BASE}${search}${hash}`;
  }

  function openApp() {
    hasAttemptedOpen = true;
    opening = true;

    if (typeof window !== "undefined") {
      window.location.href = buildAppLinkUrl();

      // Si la app no se abre, mantenemos el fallback visible.
      window.setTimeout(() => {
        opening = false;
      }, 1200);
    }
  }

  onMount(() => {
    const shouldAutoRedirect =
      window.sessionStorage.getItem(AUTO_REDIRECT_STORAGE_KEY) !== "1";

    if (!shouldAutoRedirect) {
      opening = false;
      return;
    }

    window.sessionStorage.setItem(AUTO_REDIRECT_STORAGE_KEY, "1");

    const timer = window.setTimeout(() => {
      openApp();
    }, AUTO_REDIRECT_DELAY_MS);

    return () => {
      window.clearTimeout(timer);
    };
  });
</script>

<svelte:head>
  <title>Abriendo Kupi…</title>
  <meta name="robots" content="noindex" />
</svelte:head>

<main class="container" aria-busy={opening}>
  <section class="card" role="status" aria-live="polite">
    <h1>Abriendo la app</h1>
    <p>
      Estamos intentando redirigirte a Kupi con App Links.
      {#if hasAttemptedOpen && !opening}
        Si no pasó nada, puede que la app no esté instalada o que el sistema
        haya bloqueado el intento.
      {/if}
    </p>

    <button type="button" onclick={openApp}>
      {opening ? "Intentando abrir…" : "Volver a intentar"}
    </button>
  </section>
</main>

<style>
  :global(body) {
    margin: 0;
    font-family:
      Inter,
      system-ui,
      -apple-system,
      BlinkMacSystemFont,
      "Segoe UI",
      sans-serif;
  }

  .container {
    min-height: 100svh;
    display: grid;
    place-items: center;
    padding: 1.5rem;
    background: linear-gradient(180deg, #f8fafc 0%, #eef2ff 100%);
  }

  .card {
    width: min(100%, 32rem);
    background: #fff;
    border-radius: 1rem;
    padding: 1.5rem;
    box-shadow: 0 8px 30px rgba(15, 23, 42, 0.08);
    text-align: center;
  }

  h1 {
    font-size: 1.25rem;
    margin: 0 0 0.75rem;
    color: #0f172a;
  }

  p {
    margin: 0 0 1.25rem;
    color: #334155;
    line-height: 1.5;
  }

  button {
    border: none;
    border-radius: 0.75rem;
    padding: 0.75rem 1rem;
    font-size: 0.95rem;
    font-weight: 600;
    cursor: pointer;
    background: #2563eb;
    color: #fff;
    transition: background 120ms ease;
  }

  button:hover {
    background: #1d4ed8;
  }
</style>
