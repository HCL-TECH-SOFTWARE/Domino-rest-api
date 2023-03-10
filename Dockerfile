FROM squidfunk/mkdocs-material
RUN apk update && apk upgrade && apk add git
RUN pip install mkdocs-awesome-pages-plugin mkdocs-git-revision-date-localized-plugin mike mkdocs-markdownextradata-plugin mkdocs-git-authors-plugin mkdocs-blog-plugin mkdocs-section-index
EXPOSE 8000