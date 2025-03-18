import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tool-modal"
export default class extends Controller {

  connect() {
  }

  openModal(event) {
    const modal = new bootstrap.Modal(document.getElementById("toolModal"));
    const plan = event.currentTarget.dataset.toolModalPlanValue;
    const current = event.currentTarget.dataset.toolModalCurrentValue;
    document.getElementById("modal-title").innerText = `${plan} plan`;

    const allFeatures = [
      "Accès aux statistiques",
      "Export des données",
      "Support client prioritaire",
      "Intégration API",
      "Accès multi-utilisateurs",
      "Stockage cloud 50GB",
      "Mises à jour automatiques",
      "Personnalisation du branding",
      "Formation et onboarding",
      "Sécurité avancée"
    ];

    let featuresToShow = [];

    if (plan === "free") {
      featuresToShow = allFeatures.slice(0, 4); // 4 premières
    } else if (plan === "business") {
      featuresToShow = allFeatures.slice(0, 7); // 7 premières
    } else if (plan === "enterprise") {
      featuresToShow = allFeatures; // Toutes
    }

    // Génération du HTML des fonctionnalités
    const listHtml = featuresToShow
      .map(feature => `<li><span class="feature-icon"><i class="fa-solid fa-check text-success"></i></span> ${feature}</li>`)
      .join("");

    // Injection dans la modale
    document.getElementById("feature-list").innerHTML = listHtml;

    if (plan === current) {
      document.getElementById("message-footer").innerText = 'This is your current plan!';
    } else {
      document.getElementById("message-footer").innerText = ''
    }

    modal.show();
  }
}
