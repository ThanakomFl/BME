ng.component('appDocuments', {
    templateUrl: WWW_ROOT + '/documents/template.html',
    bindings: {
        mode: '='
    },
    controller: ($scope, $http, $element) => {
        $scope.mode = $element[0].hasAttribute('mode') ?
            $element[0].getAttribute('mode') :
            0;
        $scope.types = [];
        $scope.documents = [];
        $scope.filteredDocuments = [];
        $scope.preview = null;
        $scope.editor = typeof EDITOR === 'undefined' ? false : EDITOR;
        $scope.filters = {
            keyword: '',
            type: 0,
            date: 0,
            month: 0,
            year: 0
        };

        $scope.loadTypes = () => {
            $http.get(`${WWW_ROOT}/api/document_types.php?mode=${$scope.mode}`)
                .then(response => {
                    if (response.status === 200) {
                        $scope.types = response.data;
                    }
                });
        };

        $scope.loadData = () => {
            $http.get(`${WWW_ROOT}/api/documents.php?mode=${$scope.mode}`)
                .then(response => {
                    if (response.status === 200) {
                        $scope.documents = response.data
                            .map(document => ({
                                    ...document,
                                    time: $scope.hasTime(document.uploaded_dt)
                                })
                            );
                        $scope.applyFilters();
                    } else {
                        alert(`พบข้อผิดพลาด - ${response.statusText}`);
                    }
                });
        };

        $scope.hasTime = dt => {
            const date = new Date(dt * 1000);
            let h = date.getHours();
            h += date.getMinutes();
            h += date.getSeconds();
            return h !== 0;
        };

        $scope.setPreview = document => {
            $scope.preview = document;
        };

        $scope.range = (min, max) => {
            const arr = [];
            for (let i = min; i <= max; i++) {
                arr.push(i);
            }
            return arr;
        };

        $scope.applyFilters = () => {
            $scope.filteredDocuments = $scope.documents.filter(document => {
                const filters = $scope.filters;
                if (filters.keyword.trim() !== ''
                    && document.file_name.toLowerCase().indexOf(filters.keyword.toLowerCase()) === -1) {
                    return false;
                }

                if (filters.type && filters.type !== parseInt(document.type)) {
                    return false;
                }

                if (filters.date || filters.month || filters.year) {
                    const dateObj = new Date(document.uploaded_dt * 1000);
                    if (filters.date && filters.date !== dateObj.getDate()) {
                        return false;
                    }
                    if (filters.month && filters.month - 1 !== dateObj.getMonth()) {
                        return false;
                    }
                    if (filters.year && filters.year - 543 !== dateObj.getFullYear()) {
                        return false;
                    }
                }

                return true;
            });
        };

        $scope.loadTypes();
        $scope.loadData();
    }
});
