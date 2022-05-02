---
layout: common
lang: ja
type: article
title: Overview
pageName: overview
---
<nav id="contentsMenu">
  <ul>
    <li><a href="#astrollOverview" class="touch anker">概要 <i class="fas fa-angle-down"></i></a></li>
    <li><a href="#appliedUsage" class="touch anker">応用 <i class="fas fa-angle-down"></i></a></li>
  </ul>
</nav>

<section id="astrollOverview">
  <div class="sectionInner">
    <h2><em>Exastro EPOCH</em> の概要</h2>
    <p>Exastro EPOCHは、高速なアプリケーション開発・デプロイ環境を提供するためのフレームワークです。コンテナベースのアプリケーション開発を支援するためのプロセス及び環境をセットで提供します。</p>
    <p><span class="loupe touch"><span class="exImage"><img src="../epoch-docs/asset/img/epoch_overview.png" alt="概要イメージ図"></span></span></p>
    
    <h3 id="feature1" class="toggleHeading">クラウドネイティブなアプリケーションのCI/CDパイプラインを即時に提供</h3>
    <div class="toggleText">
      <p>アプリケーションの開発からサービス提供までのプロセスを、一元管理するための具体的な手段の一つにCI/CDがあります。
      一方で、CI/CDを始めるためには、数多あるCI/CDツールの中から必要なものを選定し、更にそれらを適切に連携させるために構築作業や設定の投入をする必要があり、そこには多大な時間とコストを必要とします。</p>
      <p>Exastro EPOCH は、CI/CDを始めるために必要なツールを内包・連携した状態で提供しており、CI/CDをすぐに始めることができます。
      CIパイプラインでは、アプリケーションのソースコードを静的解析、および、自動テストを実施し、コンテナイメージのビルドを行います。
      CDパイプラインでは、IaCの変数にビルドしたイメージ情報をパラメータとして連携することで、各環境にビルドした最新のイメージをデプロイをできます。
      また、ステージング環境やプロダクション環境といった複数の環境を同時に管理することができます。</p>

      <div class="exImage"><img src="../epoch-docs/asset/img/epoch_feature_delivery.png" alt="Coming soon."></div>
    </div>

    <h3 id="feature2" class="toggleHeading">ワークロードを統一</h3>
    <div class="toggleText">
      <div class="rightImage"><img src="../epoch-docs/asset/img/epoch_feature_centralized-management.png" alt="Coming soon."></div>
      <p>Exastro EPOCHは、GitLab、SonerQube、TEKTON、ArgoCD、Exastro IT Automation といった様々なツールと連携しています。
      一方で、それらのツールのUIから個別に操作を行うとすると、それだけで各ツールの学習のために多大なコストを払うことになります。</p>
      <p>CI/CDのステータスを各CI/CDツールを介さずに一括で確認・操作できる仕組みが提供されており、簡単にDevOpsを実現できます。</p>
    </div>

    <h3 id="feature3" class="toggleHeading">GitOpsに対応した環境の展開</h3>
    <div class="toggleText">
      <p>アプリケーションのソースコードの管理のために、Gitを利用しているユーザは多くいるでしょう。しかし、Kubernetesにおけるマニフェストファイルのようなコードとして保存された設定ファイルであるIaC(Infrastructure as Code)は、どのように管理するのが適切なのでしょうか。</p>
      <p>答えは、IaCもアプリケーションのソースコードと同様にバージョン管理システム上で管理するのが望ましいです。</p>
      <p>Exastro EPOCH には、内包あるいは外部のGitリポジトリと連携することで、アプリケーションとIaCの両方を一元管理できます。
      それにより、アプリケーションチームとインフラチームが同じGit上でファイルの管理ができるため、お互いの情報連携をスムーズに行うことも可能です。
      また、IaCのバージョン管理を行うことも当然できるので、アプリケーションのデプロイや構成変更で問題が発生した場合の切り戻し作業や追跡がしやすくなります。</p>
      <div class="exImage"><img src="../epoch-docs/asset/img/epoch_feature_gitops.png" alt="Coming soon."></div>
    </div>
    
    <h3 id="feature4" class="toggleHeading">カナリアリリース/ブルーグリーンデプロイメントに対応(Experimental)</h3>
    <div class="toggleText">
      <p>従来型の人手によるリリース方法は、作業の計画や調整そしてプロダクション環境と近いステージング環境を構築するために多くの時間を費やす必要があり、結果として多くのビジネスの機会を逃してしまいます。</p>
      <p>Exastro EPOCHはリリース・デプロイメントの仕組みに、カナリアリリースやブルーグリーンデプロイメントを提供しています(現在は、実験的な機能)。
      これは、プロダクション環境に非常に近いステージング環境を同時かつ迅速に提供することで、リリース前の最終確認を容易にするためのサービス提供方法です。
      また、カナリアリリースやブルーグリーンデプロイを利用することで、リリースに関する問題が発覚した場合に、迅速に環境を戻すことが可能な仕組みも同時に提供しています。</p>
      <div class="exImage"><img src="../epoch-docs/asset/img/epoch_feature_blue-green-deployment.png" alt="Coming soon."></div>
    </div>
    
    <h3 id="feature5" class="toggleHeading">宣言的IaCの環境依存パラメータをシステム上で管理</h3>
    <div class="toggleText">
      <p>プロダクション環境とステージング環境はなるべく同じ状態にしておくことが望ましいですが、Kubernetesのようにマニフェストファイル(宣言型IaC)を管理する場合、各環境ごとに同じ項目と異なる項目を適切に管理する必要があります。
      管理が適切に行われない場合、誤ったマニフェストファイルをKubernetesクラスタに適用することで、サービス障害を発生させてしまう可能性があります。
      例えば、コンテナ自体のポート番号は普遍ですが、NodePortの場合は重複が許されないため環境ごとに異なるポート番号を指定する必要があります。</p>
      <p>Exastro EPOCHでは、マニフェストファイル(宣言型IaC)の共通する部分はテンプレートとして管理し、異なる部分をパラメータとして管理することで適切に宣言型IaC管理する機能を持っています。
      上記の例では、コンテナのポートはマニフェストファイルのテンプレート内で管理し、NodePortはパラメータとして管理することがExastro EPOCHを使うことで簡単に実現できます。</p>
      <div class="exImage"><img src="../epoch-docs/asset/img/epoch_feature_parameter-management.png" alt="Coming soon."></div>
    </div>
  </div>
</section>

<section id="appliedUsage">
  <div class="sectionInner">
    <h2><em>Exastro EPOCH</em> の応用</h2>
    <div class="leftImage image25"><img src="../it-automation-docs/asset/img/coming_soon.png" alt="Coming soon."></div>
    <p>Exastro OASEの応用については後日公開予定です。</p>
  </div>
</section>